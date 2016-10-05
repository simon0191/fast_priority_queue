require "spec_helper"

describe FastPriorityQueue do
  it "has a version number" do
    expect(FastPriorityQueue::VERSION).not_to be nil
  end

  it "defines hello_world method in rust" do
    expect(FastPriorityQueue.new.hello_world).to eq('hello world')
  end
end
