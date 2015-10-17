require 'bundler'
Bundler.require

require 'socket'
require 'ostruct'
require 'benchmark/ips'
require 'faker'
require 'rom-mapper'

begin
  require 'byebug'
rescue LoadError
end

# Enable and start GC before each job run. Disable GC afterwards.
#
# Inspired by https://www.omniref.com/ruby/2.2.1/symbols/Benchmark/bm?#annotation=4095926&line=182
class GCSuite
  def warming(*)
    run_gc
  end

  def running(*)
    run_gc
  end

  def warmup_stats(*)
  end

  def add_report(*)
  end

  private

  def run_gc
    GC.enable
    GC.start
    GC.disable
  end
end

def hr
  puts "*" * 80
end

def run(title, &block)
  benchmark(title, &block)
end

def git_state
  state = `git status -uno --porcelain`.split($/).reject do |line|
    line.split(' ').last.start_with?('benchmarks/results/')
  end

  state.empty? ? 'clean' : "#{$/}  => #{state.join("#{$/}  => ")}"
end

def benchmark(title)
  puts "=> benchmark: #{title}"
  puts "=> host: #{Socket.gethostname}"
  puts "=> revision: #{`git rev-parse HEAD`}"
  puts "=> repo_state: #{git_state}"
  puts $/
  Benchmark.ips do |x|
    x.config(suite: GCSuite.new)
    yield x
    x.compare!
  end
  hr
end

def create_mapper(&block)
  Class.new(ROM::Mapper).tap do |mapper_klass|
    mapper_klass.instance_eval(&block)
  end
end

def build_mapper(&block)
  create_mapper(&block).build
end

def create_tuple_collection(size, &block)
  size.times.map { block.call }
end
