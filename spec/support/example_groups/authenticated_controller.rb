RSpec.shared_examples_for 'an authenticated controller' do |actions|
  context 'when the user is unauthenticated' do
    actions.each do |action,(method,params)|
      context "performing a #{method.upcase} #{action}" do
        it 'denies access' do
          begin
            send(method, action, params)
          rescue => e
            raise "Expected #{method.upcase} #{action} to require authentication, but it did not"
          end

          if params[:format] == 'js'
            expect(response.status).to eq 401
          else
            expect(response).to redirect_to new_user_session_path
            expect(flash[:alert]).to eq I18n.t('devise.failure.unauthenticated')
          end
        end
      end
    end
  end

  context 'when the user is authenticated' do
    actions.each do |action,(method,params)|
      context "performing a #{method.upcase} #{action}" do
        it 'allows access' do
          begin
            sign_in authenticatable
          rescue NameError
            raise "set an authenticatable object to sign in with\nie: let(:authenticatable) { stub_model(User) }"
          end

          begin
            send(verb, action, action_params)
          rescue
          end

          if params[:format] == 'js'
            expect(response.status).to_not eq 401
          else
            expect(response).to_not redirect_to new_user_session_path
            expect(flash[:alert]).to_not eq I18n.t('devise.failure.unauthenticated')
          end
        end
      end
    end
  end
end
