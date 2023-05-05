require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:task) { create(:task) }
  let(:valid_attributes) { { title: 'タスクのタイトル', body: 'タスクの本文' } }
  let(:invalid_attributes) { { title: '', body: '' } }

  describe "GET /index" do
    it "renders the index template" do
      get tasks_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    it "renders the show template" do
      get task_path(task)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    it "renders the new template" do
      get new_task_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    it "renders the edit template" do
      get edit_task_path(task)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post tasks_path, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post tasks_path, params: { task: valid_attributes }
        expect(response).to redirect_to(task_path(Task.last))
        expect(response).to have_http_status(:found)
      end
    end

    context "with invalid params" do
      it "does not create a new Task" do
        expect {
          post tasks_path, params: { task: invalid_attributes }
        }.not_to change(Task, :count)
      end

      it "re-renders the 'new' template with unprocessable entity status" do
        post tasks_path, params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /update" do
    context "with valid params" do
      let(:new_attributes) { { title: '新しいタスクのタイトル', body: '新しいタスクの本文' } }

      it "updates the requested task" do
        put task_path(task), params: { task: new_attributes }
        task.reload
        expect(task.title).to eq(new_attributes[:title])
        expect(task.body).to eq(new_attributes[:body])
      end

      it "redirects to the updated task" do
        put task_path(task), params: { task: new_attributes }
        expect(response).to redirect_to(task_path(task))
        expect(response).to have_http_status(:found)
      end
    end

    context "with invalid params" do
      it "does not update the requested task" do
        put task_path(task), params: { task: invalid_attributes }
        task.reload
        expect(task.title).not_to eq(invalid_attributes[:title])
        expect(task.body).not_to eq(invalid_attributes[:body])
      end

      it "re-renders the 'edit' template with unprocessable entity status" do
        put task_path(task), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task_to_destroy = create(:task)
      expect {
        delete task_path(task_to_destroy)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list with see other status" do
      delete task_path(task)
      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end