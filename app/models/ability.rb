# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(account)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    if account.present?
      if account.admin?
        can :manage, [Administrator, Employee, Employer, Group, Survey]
        can %i[index show], SurveyEmployeeConnection, is_conducted: true
      elsif account.employer?
        can :manage, Employee, employer_id: account.account_user.id
        can %i[index show], SurveyEmployeeConnection,
            is_conducted: true,
            employee: { employer: { id: account.account_user.id } }
        can :manage, Group
        can :manage, Survey, employer_id: account.account_user.id
        cannot :manage, Employer
      elsif account.employee?
        can %i[index show], SurveyEmployeeConnection,
            is_conducted: true,
            employee_id: account.account_user.id
        can [:index, :attempt, :conduct], Survey do |survey|
          survey.employer_id == account.account_user.employer.id &&
            SurveyEmployeeConnection.find_by(
              employee_id: account.account_user.id,
              survey_id: survey.id,
              is_conducted: false
            ).present?
        end
      end
    end
  end
end
