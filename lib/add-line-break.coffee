AddLineBreakView = require './add-line-break-view'
{CompositeDisposable} = require 'atom'

module.exports = AddLineBreak =
  addLineBreakView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @addLineBreakView = new AddLineBreakView(state.addLineBreakViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @addLineBreakView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'add-line-break:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @addLineBreakView.destroy()

  serialize: ->
    addLineBreakViewState: @addLineBreakView.serialize()

  toggle: ->
    console.log 'AddLineBreak was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
