require 'spec_helper'
describe 'mediawikiwindows' do
  context 'with default values for all parameters' do
    it { should contain_class('mediawikiwindows') }
  end
end
