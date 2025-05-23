# frozen_string_literal: true

# RESTful API controller for retrieving information about {Stack stacks}. Used
# by the Vue.js front-end to populate pages with stack information.

class StacksController < ApplicationController
  before_action :find_stack, only: :show
  respond_to :json

  # Renders JSON information about a stack, including all of its cards. If a
  # list of match results is given, the resulting JSON will include an ordered
  # ranking of cards.
  #
  # Routes
  # ------
  #
  # * `GET /stacks/:id.json`
  #
  # Path Parameters
  # ---------------
  #
  # |      |                                                 |
  # |:-----|:------------------------------------------------|
  # | `id` | The base-36 ID of a {Stack} to render data for. |
  #
  # Query Parameters
  # ----------------
  #
  # |     |                                                                          |
  # |:----|:-------------------------------------------------------------------------|
  # | `m` | An encoded array of match results (see `encoding.js`) to order cards by. |

  def show
    if params[:m].present?
      matches = decode_matches(params[:m])
      @rankings = @stack.rank(matches)
    end

    respond_with @stack
  end

  # Creates a new Stack from the given parameters.
  #
  # Routes
  # ------
  #
  # * `POST /stacks.json`
  #
  # Body Parameters
  # ---------------
  #
  # |         |                                                 |
  # |:--------|:------------------------------------------------|
  # | `stack` | Parameterized hash of {Stack stack} properties. |

  def create
    @stack = Stack.create(stack_params)
    respond_with @stack
  end

  private

  def find_stack
    @stack = Stack.find_by_hash!(params[:id]) # rubocop:disable Rails/DynamicFindBy
  end

  def stack_params = params.expect(stack: %i[name card_names])

  MATCH_TYPES = [nil, :first, :second, :both].freeze
  private_constant :MATCH_TYPES

  def decode_matches(m)
    num = Integer(m, 36)
    str = num.to_fs(4)
    arr = str.chars
    arr.map { MATCH_TYPES[Integer(it)] }
  end
end
