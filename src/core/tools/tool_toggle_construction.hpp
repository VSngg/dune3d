#include "tool_common.hpp"
#include "in_tool_action/in_tool_action.hpp"

namespace dune3d {

class ToolToggleConstruction : public ToolCommon {
public:
    using ToolCommon::ToolCommon;

    ToolResponse begin(const ToolArgs &args) override;
    ToolResponse update(const ToolArgs &args) override;
    bool is_specific() override
    {
        return true;
    }

private:
};
} // namespace dune3d
