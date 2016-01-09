shared_examples_for 'an action creating object' do |*args|
  opts = args.extract_options!

  subject { model_class.last }

  let(:model_class) { described_class.controller_name.classify.constantize }
  let(:new_attributes) { attributes.slice(*args.flatten).stringify_keys }

  if opts[:expect_failure]
    it { expect { call_request }.not_to change { model_class.count } }
  else
    it { expect { call_request }.to change { model_class.count }.by(1) }
  end

  unless opts[:expect_failure]
    context 'after call_request' do
      before { call_request }

      it { expect(subject.attributes).to include(new_attributes) }
    end
  end
end
