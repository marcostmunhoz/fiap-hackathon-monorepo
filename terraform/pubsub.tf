resource "google_pubsub_topic" "pubsub_topic" {
  depends_on = [google_project_service.services]

  name = "hackathon-worker-topic"
}

resource "google_pubsub_subscription" "pubsub_subscription" {
  name  = "hackathon-worker-subscription"
  topic = google_pubsub_topic.pubsub_topic.name
}
