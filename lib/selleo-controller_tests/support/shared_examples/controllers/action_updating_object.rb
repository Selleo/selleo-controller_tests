shared_examples_for 'an action updating object' do |*args|
  opts = args.extract_options!

  subject { object }

  let(:model_name) { described_class.controller_name.singularize }
  let(:object) { public_send(model_name) }
  let(:new_attributes) { attributes }

  context 'after call_request' do
    before { call_request }

    if opts[:expect_failure]
      it { expect(subject.reload.attributes).to_not include(new_attributes.slice(*args.flatten).stringify_keys) }
    else
      it { expect(subject.reload.attributes).to include(new_attributes.slice(*args.flatten).stringify_keys) }
    end
  end
end
