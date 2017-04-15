module AchieveCenter
  module Handler
    class Blog

      def self.update_for_blog_amount(achieve, blog)
        conditions = achieve.conditions || {}
        target_count = conditions['total'] || -1
        return if target_count < 0

        ua = UserAchievement.by_owner(achieve.id, blog.user_id)
        return if ua.completed

        current_count = Article.solution.where(user_id: blog.user_id).count
        if current_count < target_count
          ua.assign_attributes(current: current_count, total: target_count)
        else
          ua.assign_attributes(
            current: target_count, total: target_count,
            completed: true, completed_at: DateTime.now
          )
        end
        ua.save
      end

      def self.handle(event)
        blog = Article.find_by(id: event['blog_id'])
        return if blog.blank?
        Achievement.by_type(Achievement::TYPE_AMOUNT).find_each do |achieve|
          conditions = achieve.conditions || {}
          case conditions['type']
          when Achievement::AMOUNT_TYPE[:blog]
            update_for_blog_amount(achieve, blog)
          else
            AchieveCenter.logger.warn("[GameCenter] unknown ammount type #{conditions}")
            next
          end
        end
        # handle blog end
      end

    end
  end
end