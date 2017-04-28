{CompositeDisposable} = require 'atom'
bignum                  = require 'bignum'
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

  randint: (min=0, max) ->  min + Math.floor(Math.random() * (max - min + 1))
  genCapnpID: -> bignum(@randint(0, Math.pow(2, 64))).or(bignum(1).shiftLeft(63)).toString(16)
     #Number(@randint(0, Math.pow(2,64)) | 1<<63).toString(16) #convert to hex.
  newCapnpID: ->
    capnpID = @genCapnpID()
    editor = atom.workspace.getActiveTextEditor()
    txt = editor.getText()
    editor.setText("#{capnpID}\n\n"+txt)
