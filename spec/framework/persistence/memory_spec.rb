require_relative '../../spec_helper'
require_relative '../../../lib/app/models/contact'
require_relative '../../../lib/framework/persistence/memory'

describe 'Framework::Persistence::Memory' do
  subject{ Framework::Persistence::Memory.new }
  let(:attributes){ {name: 'Marcel', phone: '12790384848'} }
  let(:contact){ Phonebook::Model::Contact.new(attributes) }

  it 'add' do
    subject.add(contact)
    subject.all.size.should eql 1

  end
end