# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Backend::CategoriesController, type: :controller do
  before { create(:category, :with_products) }
  let(:resource_params) do
    {
      category: {
        title:       Faker::Commerce.department(1),
        description: Faker::Lorem.paragraph
      }
    }
  end

  def get_action(action)
    %i[:show :edit].include? action ? get(action, params: { id: create(:category).id }) : get(action)
  end

  shared_examples 'render template' do |action, params|
    params = {} if params.nil?
    params[:folder] = 'backend/categories' unless params.key? :folder
    it "renders the #{action} from the #{params[:folder]}" do
      get_action action
      expect(response).to render_template("#{params[:folder]}/#{action}")
    end
  end

  shared_examples 'status code' do |action, status_code|
    it "should have status code #{status_code}" do
      get_action action
      expect(response.status).to eq status_code
    end
  end

  shared_examples 'instance variable' do |action, params|
    it "should initiate the instance variable @#{params[:variable]}" do
      get_action action
      variable = params[:variable]
      expect(assigns(variable)).to be_kind_of(params[:type])
      expect(assigns(variable)).to be_new_record if params[:new_record]
      expect(assigns(variable)).to be_persisted  if params[:persisted]
    end
  end

  describe 'GET Actions' do
    describe '#index' do
      it_should_behave_like 'render template', :index
      it_should_behave_like 'status code', :index, 200
      it_should_behave_like 'instance variable', :index, variable: :categories, type: ActiveRecord::Relation
    end

    describe '#new' do
      it_should_behave_like 'render template', :new
      it_should_behave_like 'status code', :new, 200
      it_should_behave_like 'instance variable', :new, variable: :category, type: Category, new_record: true
    end

    describe '#show' do
      it_should_behave_like 'render template', :show
      it_should_behave_like 'status code', :show, 200
      it_should_behave_like 'instance variable', :show, variable: :category, type: Category, persisted: false
      it_should_behave_like 'instance variable', :show, variable: :products, type: ActiveRecord::Relation
    end

    describe '#edit' do
      it_should_behave_like 'render template', :edit
      it_should_behave_like 'status code', :edit, 200
      it_should_behave_like 'instance variable', :edit, variable: :category, type: Category
    end
  end

  describe 'POST & PUT Actions' do
    before { get_action :new }
    let(:new_template) { 'backend/categories/new' }
    describe '#create' do
      it 'should create a new category record and redirect to #show' do
        expect(response).to render_template new_template
        expect { post :create, params: resource_params }.to change(Category, :count).by(1)
        expect(response).to redirect_to Category.last
        expect(flash[:success]).not_to be_nil
      end

      it 'should not create when record not save which render the :new template' do
        expect(response).to render_template new_template
        post :create, params: { category: { title: '', description: '' } }
        expect(response).to render_template new_template
        expect(flash[:error]).not_to be_nil
      end
    end

    describe '#update' do
      before { get_action :edit }
      let(:edit_template) { 'backend/categories/edit' }
      let(:resource_params) do
        {
          id: Category.last.id,
          category: {
            title: 'Test Title',
            description: 'Test Description'
          }
        }
      end
      it 'should update category record and redirect to #show' do
        expect(response).to render_template edit_template
        put :update, params: resource_params
        category = Category.last
        expect(category.title).to eq resource_params[:category][:title]
        expect(category.description).to eq resource_params[:category][:description]
        expect(response).to redirect_to backend_category_path(category)
        expect(flash[:success]).not_to be_nil
      end

      it 'should not update when record not save which render the :edit template' do
        expect(response).to render_template edit_template
        resource_params[:category][:title] = ''
        put :update, params: resource_params
        category = Category.last
        expect(category.title).not_to eq resource_params[:category][:title]
        expect(category.description).not_to eq resource_params[:category][:description]
        expect(response).to render_template edit_template
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe 'DELETE Actions' do
    before { get_action :show }
    describe '#delete' do
      it 'should delete category record and redirect to #index' do
        expect(response).to render_template 'backend/categories/show'
        expect { delete :destroy, params: { id: Category.last.id } }.to change(Category, :count).by(-1)
        expect(response).to redirect_to backend_categories_path
        expect(flash[:warning]).not_to be_nil
      end
    end
  end
end
