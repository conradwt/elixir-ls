defmodule LSP.Requests do
  alias ElixirLS.LanguageServer.Experimental.Protocol.LspTypes
  alias ElixirLS.LanguageServer.Experimental.Protocol.Proto
  alias LSP.Types

  # Client -> Server request
  defmodule Initialize do
    use Proto

    defrequest "initialize", :shared,
      process_id: optional(integer()),
      client_info: optional(LspTypes.ClientInfo),
      locale: optional(string()),
      root_path: optional(string()),
      root_uri: string(),
      initialization_options: optional(any()),
      trace: optional(string()),
      workspace_folders: optional(list_of(Types.Workspace.Folder)),
      capabilities: optional(map_of(any()))
  end

  defmodule FindReferences do
    use Proto

    defrequest "textDocument/references", :exclusive,
      text_document: Types.TextDocument.Identifier,
      position: Types.Position
  end

  defmodule GotoDefinition do
    use Proto

    defrequest "textDocument/definition", :exclusive,
      text_document: Types.TextDocument.Identifier,
      position: Types.Position
  end

  defmodule Formatting do
    use Proto

    defrequest "textDocument/formatting", :exclusive,
      text_document: Types.TextDocument.Identifier,
      options: Types.Formatting.Options
  end

  defmodule CodeAction do
    use Proto

    defrequest "textDocument/codeAction", :exclusive,
      text_document: Types.TextDocument.Identifier,
      range: Types.Range,
      context: Types.CodeAction.Context
  end

  # Server -> Client requests

  defmodule RegisterCapability do
    use Proto

    defrequest "client/registerCapability", :shared,
      registrations: optional(list_of(LspTypes.Registration))
  end

  use Proto, decoders: :requests
end
