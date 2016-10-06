require_relative '../spec_helper'
require_relative '../../lib/app/api_v1'

describe Phonebook::APIv1 do
  include Rack::Test::Methods

  def app
    Phonebook::APIv1
  end

  describe Phonebook::APIv1 do
    let(:valid_attributes){ { name: 'Marcel', phone: '1235455667688' } }

    before do
      Phonebook::Model::Contact.repository = Framework::Persistence::Memory.new
    end

    describe 'GET /contacts' do
      it 'json: returns an empty array of contacts' do
        get '/contacts.json'
        last_response.status.should == 200
        JSON.parse(last_response.body).should == []
      end

      it 'has one contact' do
        Phonebook::Model::Contact.repository.add(Phonebook::Model::Contact.new(valid_attributes))

        get '/contacts.json'
        last_response.status.should == 200
        contacts = MultiJson.load(last_response.body, symbolize_keys: true)
        contacts.size.should eql 1
        contacts.first[:name].should eql valid_attributes[:name]
        contacts.first[:phone].should eql valid_attributes[:phone]
      end


    end

    describe 'POST /contacts' do
      it 'create with valid attributes' do
        post '/contacts', valid_attributes
        last_response.status.should == 201

        result = MultiJson.load(last_response.body, symbolize_keys: true)

        result[:id].should be_a Integer
        result[:name].should eql valid_attributes[:name]
        result[:phone].should eql valid_attributes[:phone]
      end
    end

    describe 'PUT /contacts/:id' do
      let(:new_attributes){ { name: 'Marcel Scherf', phone: '491762344545656' } }

      it 'update contact info' do
        Phonebook::Model::Contact.repository.add(Phonebook::Model::Contact.new(valid_attributes))

        last_contact = Phonebook::Model::Contact.repository.all.last
        put "/contacts/#{last_contact.id}", new_attributes

        last_response.status.should == 200

        result = JSON.parse(last_response.body).to_h
        result['name'].should eql new_attributes[:name]
        result['phone'].should eql new_attributes[:phone]
      end

    end
  end
end