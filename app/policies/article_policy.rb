class ArticlePolicy < ApplicationPolicy

  def show?
    case record.article_type
    when Article::TYPE_NEWS
      user.admin? || record.publish?
    when Article::TYPE_SOLUTION
      user.admin? || record.user_id == user.id || record.publish?
    else
      false
    end
  end

  def create?
    case record.article_type
    when Article::TYPE_NEWS
      user.admin?
    else
      true
    end
  end

  def update_or_destroy?
    case record.article_type
    when Article::TYPE_NEWS
      user.admin?
    when Article::TYPE_SOLUTION
      user.id == record.user_id || user.admin?
    else
      false
    end
  end
end
