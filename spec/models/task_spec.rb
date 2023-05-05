require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    let(:task) { build(:task, title: title, body: body) }

    context 'with valid attributes' do
      let(:title) { 'タスクのタイトル' }
      let(:body) { 'タスクの本文' }

      it 'is valid' do
        expect(task).to be_valid
      end
    end

    context 'with an empty title' do
      let(:title) { '' }
      let(:body) { 'タスクの本文' }

      it 'is invalid' do
        expect(task).to_not be_valid
        expect(task.errors[:title]).to include("can't be blank")
      end
    end

    context 'with an empty body' do
      let(:title) { 'タスクのタイトル' }
      let(:body) { '' }

      it 'is invalid' do
        expect(task).to_not be_valid
        expect(task.errors[:body]).to include("can't be blank")
      end
    end

    context 'with both title and body empty' do
      let(:title) { '' }
      let(:body) { '' }

      it 'is invalid' do
        expect(task).to_not be_valid
        expect(task.errors[:title]).to include("can't be blank")
        expect(task.errors[:body]).to include("can't be blank")
      end
    end
  end
end
