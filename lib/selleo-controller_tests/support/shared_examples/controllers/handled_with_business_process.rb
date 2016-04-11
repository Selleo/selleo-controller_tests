# it_behaves_like 'action handled with business process service', AuctionEnd::SetOwner do
#   let(:parameters) { {item_id: item.to_param} }
# end

shared_examples 'action handled with business process service' do |klass, *args|

  service_object_name = klass.name.underscore

  context service_object_name do
    let(:service_object) { double(service_object_name) }

    it 'is properly called' do
      expect(klass).to receive(:call).with(parameters).and_return(service_object)
      call_request
    end
  end
end
