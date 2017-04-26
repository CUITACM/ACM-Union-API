module AchieveCenter
  module Handler
    class Spider

      def self.update_for_ac_amount(achieve, submit)
        conditions = achieve.conditions || {}
        should_ac = conditions['total'] || -1
        return if should_ac < 0

        ua = UserAchievement.by_owner(achieve.id, submit.user_id)
        return if ua.completed

        current_ac_count = Submit.user_accepted(submit.user_id).count
        if current_ac_count < should_ac
          ua.assign_attributes(current: current_ac_count, total: should_ac)
        else
          ua.assign_attributes(
            current: should_ac, total: should_ac,
            completed: true, completed_at: DateTime.now
          )
        end
        ua.save
        AchieveCenter.logger.debug("ok => #{ua.inspect}")
      end

      def self.update_for_subject(achieve, submit)
        conditions = achieve.conditions || {}
        target_problems = conditions['problems'] || []
        have_target = target_problems.any? { |p|
          p['oj'] == submit.oj_name && p['pid'] == submit.pro_id
        }
        return unless have_target

        ua = UserAchievement.by_owner(achieve.id, submit.user_id)
        return if ua.completed

        situation = ua.situation || {}
        has_problems = situation['problems'] || []
        has_problems << {oj: submit.oj_name, pid: submit.pro_id}
        situation['problems'] = has_problems
        ua.assign_attributes(
          current: has_problems.size, total: target_problems.size,
          situation: situation
        )
        if has_problems.size == target_problems.size
          ua.assign_attributes(completed: true, completed_at: DateTime.now)
        end
        ua.save
      end

      def self.handle_submit(event)
        submit = Submit.find_by(id: event['id'])
        return if submit.blank?
        Achievement.find_each do |achieve|
          # amount achievement
          case achieve.achievement_type
          when Achievement::TYPE_AMOUNT
            conditions = achieve.conditions || {}
            case conditions['amount_type']
            when Achievement::AMOUNT_TYPE[:accepted]
              update_for_ac_amount(achieve, submit)
            when Achievement::AMOUNT_TYPE[:cf_rating]
              # TODO
            else
              AchieveCenter.logger.warn("[GameCenter] unknown ammount type #{conditions}")
              next
            end

          # subject achievement
          when Achievement::TYPE_SUBJECT
            update_for_subject(achieve, submit)
          else
            next
          end
        end
        # handle submit end
      end

    end
  end
end