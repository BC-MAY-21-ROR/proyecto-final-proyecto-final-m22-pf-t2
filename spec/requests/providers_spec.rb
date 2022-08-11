require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/providers", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Provider. As you add validations to Provider, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Provider.create! valid_attributes
      get providers_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      provider = Provider.create! valid_attributes
      get provider_url(provider)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_provider_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      provider = Provider.create! valid_attributes
      get edit_provider_url(provider)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Provider" do
        expect {
          post providers_url, params: { provider: valid_attributes }
        }.to change(Provider, :count).by(1)
      end

      it "redirects to the created provider" do
        post providers_url, params: { provider: valid_attributes }
        expect(response).to redirect_to(provider_url(Provider.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Provider" do
        expect {
          post providers_url, params: { provider: invalid_attributes }
        }.to change(Provider, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post providers_url, params: { provider: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested provider" do
        provider = Provider.create! valid_attributes
        patch provider_url(provider), params: { provider: new_attributes }
        provider.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the provider" do
        provider = Provider.create! valid_attributes
        patch provider_url(provider), params: { provider: new_attributes }
        provider.reload
        expect(response).to redirect_to(provider_url(provider))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        provider = Provider.create! valid_attributes
        patch provider_url(provider), params: { provider: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested provider" do
      provider = Provider.create! valid_attributes
      expect {
        delete provider_url(provider)
      }.to change(Provider, :count).by(-1)
    end

    it "redirects to the providers list" do
      provider = Provider.create! valid_attributes
      delete provider_url(provider)
      expect(response).to redirect_to(providers_url)
    end
  end
end
