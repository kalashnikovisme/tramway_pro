class TramwayDevDecorator < Tramway::Core::ApplicationDecorator
  delegate_attributes :title
end
