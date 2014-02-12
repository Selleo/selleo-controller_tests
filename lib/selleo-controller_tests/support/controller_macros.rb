module Selleo
  module ControllerMacros
    def login_user
      let(:current_user) { FactoryGirl.create(:user) }
      before do
        allow(controller).to receive(:current_user).and_return(current_user)
      end
    end

    def logout_user
      before { allow(controller).to receive(:current_user).and_return(nil) }
    end

    def with_params(&block)
      _context = context 'with params' do
        before do
          controller.params[:controller] = described_class.name.to_s.underscore.split('_')[0..-2].join('_')
          params.each do |k, v|
            controller.params[k] = v
          end
        end
      end
      _context.class_eval &block
    end
  end
end
