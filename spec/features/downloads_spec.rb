require 'spec_helper'

describe 'downloads' do
  it 'should always be able to display a script version' do
    visit version_path

    md5_hash = page.html.strip.length
    expect(md5_hash).to eq(32)
  end
end
