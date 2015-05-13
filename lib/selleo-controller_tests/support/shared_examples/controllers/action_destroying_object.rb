shared_examples_for 'an action destroying object' do |*args|
  opts = args.extract_options!

  subject { object }

  let(:model_name) { described_class.controller_name.singularize }
  let(:object) { public_send(model_name) }

  if opts[:expect_failure]
    it { expect { call_request }.to_not change { object.class.count } }
  else
    it { expect { call_request }.to change { object.class.count }.by(-1) }
  end
end
