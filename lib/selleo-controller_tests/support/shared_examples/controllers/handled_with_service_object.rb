shared_examples 'action handled with service object' do |klass, *args|
  # "CompanyUserCreator" -> "company_user"

  service_object_name = klass.name.underscore
  resource = service_object_name.split('_')[0..-2].join('_')

  let(:parameters) { kind_of(resource.classify.constantize) }

  context klass do
    let(:service_object) { double(service_object_name) }

    it 'is properly called' do
      expect(klass).to receive(:new).with(*Array.wrap(parameters) ).and_return(service_object)
      expect(service_object).to receive(:save).and_return(true)
      call_request
    end
  end
end
