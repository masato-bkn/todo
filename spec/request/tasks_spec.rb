require 'rails_helper'

RSpec.describe TasksController, type: :request do
  describe 'GET /' do
    subject do
      get root_path
      response
    end

    it 'returns success' do
      expect(subject).to have_http_status(:success)
    end
  end

  describe 'POST /tasks' do
    let :task do
      'test1'
    end

    subject do
      post tasks_path(task: task)
    end

    context 'taskが入力されている場合' do
      it 'redirect to /' do
        expect(subject).to redirect_to(tasks_url)
      end

      it 'taskが一件作成されていること' do
        expect {
          subject
        }.to change(Task, :count).by(1)
      end
    end

    context 'taskが入力されてない場合' do
      let :task do
        ''
      end

      it 'render to tasks/new' do
        expect(subject).to render_template('tasks/new')
      end

      it 'taskが作成されないこと' do
        expect {
          subject
        }.not_to change(Task, :count)
      end
    end

    context 'taskが101文字以上の場合' do
      let :task do
        'a'*101
      end

      it 'render to tasks/new' do
        expect(subject).to render_template('tasks/new')
      end

      it 'taskが作成されないこと' do
        expect {
          subject
        }.not_to change(Task, :count)
      end
    end

    describe 'PATCH /tasks/:id' do
      subject do
        patch task_path(id: id, task: {task: task2})
      end

      before :each do
        Task.create(task: 'test1')
      end

      context 'taskが入力されている場合' do
        let :id do
          Task.last.id
        end

        let :task2 do
          'test2'
        end

        it 'redirect to /' do
          expect(subject).to redirect_to(tasks_url)
        end

        it 'taskがtest2に更新されていること' do
          subject
          expect(Task.last.task).to eq(task2)
        end
      end

      context 'taskが入力されていない場合' do
        let :id do
          Task.last.id
        end

        let :task2 do
          ''
        end

        it 'render tasks/edit' do
          expect(subject).to render_template('tasks/edit')
        end

        it 'taskが更新されていないこと' do
          subject
          expect(Task.last.task).to eq('test1')
        end
      end

      context 'taskが101文字以上の場合' do
        let :id do
          Task.last.id
        end

        let :task2 do
          'a'*101
        end

        it 'render tasks/edit' do
          expect(subject).to render_template('tasks/edit')
        end

        it 'taskが更新されていないこと' do
          subject
          expect(Task.last.task).to eq('test1')
        end
      end

      describe 'DELETE /tasks/:id' do
        subject do
          delete task_path(id: id)
        end

        before :each do
          Task.create(task: 'test1')
        end

        let :id do
          Task.last.id
        end

        it 'render tasks/edit' do
          expect(subject).to redirect_to(tasks_url)
        end

        it 'taskが削除されていること' do
          subject
          expect(Task.find_by(id: id)).to eq(nil)
        end
      end
    end
  end
end