shared_examples_for 'an action updating object' do |*args|
  opts = args.extract_options!

  subject { object }

  let(:model_name) { described_class.controller_name.singularize }
  let(:object) { public_send(model_name) }
  let(:new_attributes) { attributes.slice(*args.flatten).stringify_keys }

  context 'after call_request' do
    before do
      if new_attributes.empty?
        warn <<MESSAGE
Unable to check if #{subject.class} was updated.
You have to provide symbol of field that could have been changed in the process of update
#{self.class.parent.metadata[:location]}
MESSAGE
      else
        call_request
      end
    end

    if opts[:expect_failure]
      it { expect(subject.reload.attributes).to_not include(new_attributes) }
    else
      it { expect(subject.reload.attributes).to include(new_attributes) }
    end
  end
end
