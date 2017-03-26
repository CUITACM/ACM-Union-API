module AchieveCenter
  module Handler
    class Spider

      def self.update_user_achievement(achieve, submit)
        ua = UserAchievement.find_or_initialize_by(
          achievement_id: achieve.id,
          user_id: submit.user_id
        )
      end

      def self.run_with_submit(event)
        submit = Submit.find_by(id: event['id'])
        Achievement.by_type(Achievement::TYPE_AMOUNT)
          .find_each(batch_size: 500) { |achieve|
            conditions = achieve.conditions || {}
            case conditions['type']
            when Achievement::AMOUNT_TYPE[:accepted]
              # TODO
            else
              next
            end
          }
      end

    end
  end
end