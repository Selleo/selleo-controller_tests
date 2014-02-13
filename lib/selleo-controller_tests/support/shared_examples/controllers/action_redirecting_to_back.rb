shared_examples 'an action which redirects to :back' do
  before { request.env['HTTP_REFERER'] = '/previous_path' }

  it { expect(call_request).to redirect_to('/previous_path') }
end
