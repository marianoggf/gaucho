require "rails_helper"

module Gaucho
  RSpec.describe CustomerCaMovementsController, type: :routing do
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/customer_ca_movements").to route_to("customer_ca_movements#index")
      end

      it "routes to #new" do
        expect(:get => "/customer_ca_movements/new").to route_to("customer_ca_movements#new")
      end

      it "routes to #show" do
        expect(:get => "/customer_ca_movements/1").to route_to("customer_ca_movements#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/customer_ca_movements/1/edit").to route_to("customer_ca_movements#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/customer_ca_movements").to route_to("customer_ca_movements#create")
      end

      it "routes to #update via PUT" do
        expect(:put => "/customer_ca_movements/1").to route_to("customer_ca_movements#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/customer_ca_movements/1").to route_to("customer_ca_movements#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/customer_ca_movements/1").to route_to("customer_ca_movements#destroy", :id => "1")
      end

    end
  end
end
