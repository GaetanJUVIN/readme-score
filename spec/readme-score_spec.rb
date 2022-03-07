require File.expand_path('../spec_helper', __FILE__)

describe ReadmeScore do
  describe ".for" do
    it "should load markdown content" do
      content = File.read('./data/sample_readme.md')
      expect(ReadmeScore::Document).to receive(:load).with(content).and_call_original
      ReadmeScore.for(content)
    end
  end
end
