shared_examples_for 'an action rendering view' do
  let(:view) do
    parent = self.class.parent
    if parent.description.first == '#'
      parent.description[/\w+/]
    else
      parent.parent.description[/\w+/]
    end
  end

  it { expect(call_request).to render_template(view) }
end
