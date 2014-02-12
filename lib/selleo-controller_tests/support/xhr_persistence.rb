module Selleo
  module XhrPersistence
    def xhr(*)
      allow(@request).to receive(:was_xhr?).and_return(true)
      super
    end
  end
end
