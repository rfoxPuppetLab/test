require 'spec_helper'
describe 'winadmintools' do
  context 'with default values for all parameters' do
    it { should contain_class('winadmintools') }
  end
end
