module Api
  module V1
    class DisruptionsController < ApiController
      def index
        # Download XML directly on disk
        IO.copy_stream(open(TIMS_FEED_URL), 'tmp/tims_feed.xml')

        # We use Nokogiri's SAX parser (event-drive) to avoid parsing huge DOM
        # representations of the XML feed. This would potentially kill our
        # server memory and it'd be considerably slower.
        # We also use an XML file on the disk as the source, instead of streaming
        # it directly from the internet to keep memory utilisation at a minimum.
        tims_document = TimsDocument.new
        Nokogiri::XML::SAX::Parser.new(tims_document).parse_file('tmp/tims_feed.xml')

        render json: tims_document.points.to_json
      end
    end
  end
end
