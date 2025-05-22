#!/bin/python
from enum import Enum

from i3ipc import Connection

EXCLUDED_OUTPUTS = ["__i3"]

connection = Connection()


class RenameWorkspacesMode(Enum):
    APPEND_STRING_TO_WORKSPACES = 1
    RESET_RENAMED_WORKSPACES = 2


def append_string_to_workspaces(append_string, workspace_name):
    """Rename the given workspace by appending a string to the workspace name."""
    rename_workspace(workspace_name, f"{workspace_name}{append_string}")


def get_outputs():
    """Get the available outputs, excluding outputs in the EXCLUDED_OUTPUTS variable."""
    outputs = []
    tree = connection.get_tree()
    for node in filter(
        lambda node: node.type == "output" and node.name not in EXCLUDED_OUTPUTS, tree
    ):
        workspaces = node.nodes[1].nodes
        if workspaces:
            outputs.append((node, workspaces))
    return outputs


def rename_workspace(original_workspace_name, new_workspace_name):
    """Rename a workspace."""
    connection.command(
        f'rename workspace "{original_workspace_name}" to "{new_workspace_name}"'
    )


def rename_workspaces(append_string, outputs, rename_workspaces_mode):
    """Iterate over the workspaces and rename them."""
    workspace_counter = 1
    for output in outputs:
        for workspace in output[1]:
            workspace_name = workspace.name
            if (
                rename_workspaces_mode
                is RenameWorkspacesMode.APPEND_STRING_TO_WORKSPACES
            ):
                append_string_to_workspaces(append_string, workspace_name)
            elif (
                rename_workspaces_mode is RenameWorkspacesMode.RESET_RENAMED_WORKSPACES
            ):
                reset_renamed_workspaces(
                    append_string, workspace_counter, workspace_name
                )
            else:
                raise ValueError("Unexpected rename_workspaces_mode.")
            workspace_counter += 1


def reset_renamed_workspaces(append_string, workspace_counter, workspace_name):
    """Rename the given workspace according to its numbered position (from left to right, across outputs)."""
    rename_workspace(f"{workspace_name}{append_string}", workspace_counter)


def reset_workspaces(append_string, outputs):
    """See append_string_to_workspaces, rename_workspaces, and reset_renamed_workspaces functions for more information."""
    rename_workspaces(
        append_string, outputs, RenameWorkspacesMode.APPEND_STRING_TO_WORKSPACES
    )
    rename_workspaces(
        append_string, outputs, RenameWorkspacesMode.RESET_RENAMED_WORKSPACES
    )


outputs = get_outputs()

# Sort outputs by position, from left to right
outputs.sort(key=lambda output: output[0].rect.x)

reset_workspaces("...", outputs)
