var ReforgedJSConnection = function(_parent)
{
    MSUBackendConnection.call(this);
    this.mModID = Reforged.mID;
    this.mID = Reforged.mJSConnectionID;
}

ReforgedJSConnection.prototype = Object.create(MSUBackendConnection.prototype);
Object.defineProperty(ReforgedJSConnection.prototype, 'constructor', {
    value: ReforgedJSConnection,
    enumerable: false,
    writable: true
});

registerScreen(Reforged.mJSConnectionID, new ReforgedJSConnection());
