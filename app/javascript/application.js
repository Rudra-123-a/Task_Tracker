// Import Turbo for faster navigation
import "@hotwired/turbo-rails";

// Import Stimulus controllers (if used)
import "controllers";

// Import Rails UJS to enable `method: :delete` in `link_to`
import Rails from "@rails/ujs";
Rails.start();
