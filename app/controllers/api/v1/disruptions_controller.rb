module Api
  module V1
    class DisruptionsController < ApiController
      def index
        render json: disruption_points_array.to_json
      end

      private

      def disruption_points_array
        Rails.cache.fetch('disruption_points', expires_in: 5.minutes, race_condition_ttl: 10) do
          # Download XML directly on disk
          IO.copy_stream(open(TIMS_FEED_URL), 'tmp/tims_feed.xml')

          # We use Nokogiri's SAX parser (event-driven) to avoid parsing huge
          # DOM representations of the XML feed. This could potentially exhaust
          # our server memory and also be considerably slower.
          # Additionally, we use an XML file from the disk as the source,
          # instead of streaming it directly from the internet to keep memory
          # utilisation as low as possible.
          tims_document = TimsDocument.new
          Nokogiri::XML::SAX::Parser.new(tims_document).parse_file('tmp/tims_feed.xml')

          tims_document.points
        end
      end
    end
  end
end
