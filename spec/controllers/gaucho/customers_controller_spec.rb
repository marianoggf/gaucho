require 'rails_helper'

module Gaucho
  RSpec.describe CustomersController, type: :controller do
    routes { Gaucho::Engine.routes }
    context "GET #index" do
      before do
        10.times { create(:customer) } 
        get :index, params
      end
      context "when retrieving all customers" do
        let(:params) { {} }
        subject { Customer.all }
        it { expect(assigns(:customers)).to eq(subject) }
        it_behaves_like 'all instances returner'
      end
    end

  end
end
