require_relative '../../spec_helper'
require_relative '../../../lib/app/models/contact'
require_relative '../../../lib/framework/persistence/redis'

describe 'Framework::Persistence::Redis' do

  subject{ Framework::Persistence::Redis.new(Phonebook::Model::Contact, 'phonebook_test') }

  before do
    subject.clear!
  end

  after do
    subject.clear!
  end


  let(:attributes){ {name: 'Marcel', phone: '12790384848'} }
  let(:contact){ Phonebook::Model::Contact.new(attributes) }

  it 'add' do
    subject.add(contact)
    results = subject.all
    results.size.should eql 1
    results.first.should be_a Phonebook::Model::Contact
  end
end