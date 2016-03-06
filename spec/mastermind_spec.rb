require 'spec_helper'

describe Mastermind do
  it 'has a version number' do
    expect(Mastermind::VERSION).not_to be nil
  end
end

module Mastermind
  describe "DecodeBoard" do

    context "#initialize" do
      it "initializes the DecodeBoard with a board" do
        expect { DecodeBoard.new }.to_not raise_error
      end
    end

  end
end
