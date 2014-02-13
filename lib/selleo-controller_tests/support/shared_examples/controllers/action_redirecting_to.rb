shared_examples_for 'an action redirecting to' do |path|
  it { expect(call_request).to redirect_to(instance_exec(&path)) }
end
