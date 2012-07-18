require "test_helper"

module Slides
  def self.log(event, attrs)
    $attrs = attrs
    yield if block_given?
  end
end

describe Sequel::Instruments do
  before do
    $attrs = nil
  end

  describe "normal run" do
    before do
      db = Sequel::Database.new
      db.log_yield("SELECT 1") {}
    end

    it "logs SQL" do
      $attrs[:sql].must_equal "SELECT 1"
    end

    it "logs the SQL action" do
      $attrs[:action].must_equal "SELECT"
    end
  end

  describe "when an error is raised" do
    before do
      db = Sequel::Database.new
      begin
        db.log_yield("SELECT 1") { raise "an error!" }
      rescue
      end
    end

    it "logs the exception name" do
      $attrs[:exception].must_equal "RuntimeError"
    end

    it "logs the exception message" do
      $attrs[:message].must_equal "an error!"
    end

    it "logs the exception backtrace" do
      $attrs[:backtrace].any? { |l| l =~ /instruments_test/ }.must_equal true
    end
  end
end
