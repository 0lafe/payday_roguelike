-- assigns roguelike tweak data to the global tweak_data
Hooks:PostHook(WeaponTweakData, "init", "init_roguelike_tweak_data", function(self, tweak_data)
  tweak_data.roguelike = RoguelikeTweakData:new(tweak_data)
end)

RoguelikeTweakData = RoguelikeTweakData or class()

function RoguelikeTweakData:init(tweak_data)
  self.achievement_additions = {
    story_four_store = {
      job = "four_stores",
      story = "story_four_store"
    },
    story_ukrainian_job = {
      job = "ukrainian_job_prof",
      story = "story_ukrainian_job"
    },
    story_mallcrasher = {
      job = "mallcrasher",
      story = "story_mallcrasher",
    },
    story_nightclub = {
      job = "nightclub",
      story = "story_nightclub"
    }
  }
end
