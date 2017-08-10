{CompositeDisposable} = require 'atom'
capnpid                = require 'capnpid'
module.exports = CapnpID =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'capnp:newID': => @newCapnpID()

  deactivate: ->
    @subscriptions.dispose()

  newCapnpID: ->
    editor = atom.workspace.getActiveTextEditor()
    cursorPosition = editor.getCursorBufferPosition();
    txt = editor.getText()
    editor.setText("#{capnpid.newCapnpID()}\n"+txt)
    editor.setCursorBufferPosition(cursorPosition);
