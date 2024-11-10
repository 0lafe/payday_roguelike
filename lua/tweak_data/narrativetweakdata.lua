Hooks:PostHook(NarrativeTweakData, "init", "roguelike_init_narrative_tweak_data", function(self, tweak_data)
  self.contacts.escape_days = {}
  self.contacts.escape_days.name_id = "heist_contact_escape_days"
  self.contacts.escape_days.descriptions_id = "heist_contact_escape_days_description"
  self.contacts.escape_days.package = "packages/contact_bain"
  self.contacts.escape_days.assets_gui = Idstring("guis/mission_briefing/preload_contact_bain")

  self.jobs.escape_street = deep_clone(self.jobs.rat)
  self.jobs.escape_street.name_id = "heist_escape_street_hl"
  self.jobs.escape_street.briefing_id = "heist_escape_street_briefing"
  self.jobs.escape_street.contact = "escape_days"
  self.jobs.escape_street.region = "street"
  self.jobs.escape_street.chain = {
    {
      level_id = "escape_street",
      type_id = "heist_type_assault",
      type = "d",
    }
  }

  self.jobs.election_day_3 = deep_clone(self.jobs.escape_street)
  self.jobs.election_day_3.name_id = "heist_election_day_3_hl"
  self.jobs.election_day_3.briefing_id = "heist_escape_cafe_briefing"
  self.jobs.election_day_3.contact = "escape_days"
  self.jobs.election_day_3.region = "street"
  self.jobs.election_day_3.chain = {
    {
      level_id = "election_day_3",
      type_id = "heist_type_assault",
      type = "d",
    }
  }

  table.insert(self._jobs_index, "escape_street")
  table.insert(self._jobs_index, "election_day_3")
end)
