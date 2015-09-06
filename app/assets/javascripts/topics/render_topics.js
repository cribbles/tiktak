$.RenderTopics = function (el, page) {
  this.$el = $(el);
  this.$footer = $(this.$el.data("topics-footer"));
  this.topicTemplate = $(this.$el.data("topic-template")).html();
  this.page = page;
  this.fetchTopics();

  this.$footer.on("click", "a.fetch-topics", this.fetchTopics.bind(this));
}

$.RenderTopics.prototype.fetchTopics = function (e) {
  if (e) { e.preventDefault(); };

  $.ajax({
    url: "/topics.json?page=" + this.page,
    method: "get",
    dataType: "JSON",
    success: this.appendTopics.bind(this)
  });
};

$.RenderTopics.prototype.appendTopics = function (topics) {
  this.page += 1;

  topics.forEach(function(topic) {
    this.$el.append(this.renderTopic(topic));
  }, this);

  if (topics.length < 20) {
    this.$footer.text("No more topics");
  }
};

$.RenderTopics.prototype.renderTopic = function (topic) {
  var topicTemplate = _.template(this.topicTemplate);

  return topicTemplate({ topic: topic });
};

$.fn.renderTopics = function (page) {
  return this.each(function () {
    new $.RenderTopics(this, page);
  });
};
