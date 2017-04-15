module AchieveCenter
  module Event

    def on_blog_post(blog_id)
      AchieveCenter.logger.info("[AchieveCenter] onBlogPost => blog #{blog_id}")
      AchieveCenter.redis.lpush(
        AchieveCenter.mq_key,
        Oj.dump({type: 'blog', blog_id: blog_id})
      )
    end

  end
end
