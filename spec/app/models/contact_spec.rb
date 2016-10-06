require_relative '../../spec_helper'
require_relative '../../../lib/app/models/contact'

describe 'Phonebook::Model::Contact' do
  subject{ Phonebook::Model::Contact }

  let(:attributes){ {name: 'Marcel', phone: '12790384848'} }

  it 'new' do
    c = subject.new(attributes)
    c.name.should eql attributes[:name]
    c.phone.should eql attributes[:phone]
  end
end