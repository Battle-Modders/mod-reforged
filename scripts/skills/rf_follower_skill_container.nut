this.rf_follower_skill_container <- {
	m = {
		Actor = null,
		Skills = [],
		SkillsToAdd = [],
		BusyStack = 0,
		IsUpdating = false,
		IsBusy = false
	},
	function getAllSkills()
	{
		return clone this.m.Skills;
	}
	function setActor( _a )
	{
		this.m.Actor = this.WeakTableRef(_a);
	}

	function getActor()
	{
		return this.m.Actor;
	}

	function isBusy()
	{
		return this.m.BusyStack != 0;
	}

	function setBusy( _b )
	{
		if (_b)
		{
			++this.m.BusyStack;
		}
		else
		{
			--this.m.BusyStack;
		}
	}

	function add( _skill, _order = 0 )
	{
		_skill.setContainer(this);

		if (this.m.IsUpdating)
		{
			this.m.SkillsToAdd.push(_skill);
		}
		else
		{
			this.m.Skills.push(_skill);
			_skill.onAdded();
			_skill.m.IsNew = false;
			this.update();
		}
	}

	function remove( _skill )
	{
		if (!this.m.IsUpdating)
		{
			this.m.IsUpdating = true;
			local isRemoved = false;

			foreach( i, skill in this.m.Skills )
			{
				if (skill == _skill)
				{
					skill.onRemoved();
					skill.setContainer(null);
					this.m.Skills.remove(i);
					isRemoved = true;
					break;
				}
			}

			this.m.IsUpdating = false;

			if (isRemoved)
			{
				this.update();
			}
		}
		else
		{
			_skill.removeSelf();
		}
	}

	function removeByID( _skillID )
	{
		if (!this.m.IsUpdating)
		{
			this.m.IsUpdating = true;
			local isRemoved = false;

			foreach( i, skill in this.m.Skills )
			{
				if (skill.getID() == _skillID && !skill.isGarbage())
				{
					skill.onRemoved();
					skill.setContainer(null);
					this.m.Skills.remove(i);
					isRemoved = true;
					break;
				}
			}

			this.m.IsUpdating = false;

			if (isRemoved)
			{
				this.update();
			}
		}
		else
		{
			foreach( i, skill in this.m.Skills )
			{
				if (skill.getID() == _skillID)
				{
					skill.removeSelf();
					break;
				}
			}
		}
	}

	function collectGarbage( _performUpdate = true )
	{
	}

	function querySortedByOrder( _filter )
	{
		local ret = [];

		for( local i = 0; i < this.Const.ItemSlot.COUNT; i = ++i )
		{
			ret.push([]);
		}

		foreach( skill in this.m.Skills )
		{
			if (!skill.isGarbage() && skill.isType(_filter) && !skill.isHidden())
			{
				ret[0].push(this.WeakTableRef(skill));
			}
		}

		ret[0].sort(this.compareSkillsByOrder);
		return ret;
	}

	function getSkillByID( _id )
	{
		foreach( i, skill in this.m.Skills )
		{
			if (!skill.isGarbage() && skill.getID() == _id)
			{
				return skill;
			}
		}

		return null;
	}

	function hasSkill( _skillOrID )
	{
		local id;

		if (this.isKindOf(_skillOrID, "skill"))
		{
			id = _skillOrID.getID();
		}
		else
		{
			id = _skillOrID;
		}

		foreach( i, skill in this.m.Skills )
		{
			if (!skill.isGarbage() && skill.getID() == id)
			{
				return true;
			}
		}

		return false;
	}

	function update()
	{
		// if (this.m.IsUpdating)
		// {
		// 	return;
		// }

		// this.collectGarbage(false);
		// this.m.IsUpdating = true;
		// foreach( skill in this.m.Skills )
		// {
		// 	skill.onUpdate(_assetBaseProperties);
		// }

		// foreach( skill in this.m.Skills )
		// {
		// 	skill.onAfterUpdate(_assetBaseProperties);
		// }
		// this.m.IsUpdating = false;
	}

	function onNewDay()
	{
		this.m.IsUpdating = true;

		foreach( skill in this.m.Skills )
		{
			if (skill.isGarbage())
			{
				continue;
			}

			skill.onNewDay();
		}

		this.m.IsUpdating = false;
		this.update();
	}

	function compareSkillsByOrder( _skill1, _skill2 )
	{
		if (_skill1.getOrder() < _skill2.getOrder())
		{
			return -1;
		}
		else if (_skill1.getOrder() > _skill2.getOrder())
		{
			return 1;
		}
		else if (_skill1.getID() < _skill2.getID())
		{
			return -1;
		}
		else if (_skill1.getID() > _skill2.getID())
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	function compareSkillsByType( _skill1, _skill2 )
	{
		if (_skill1.getType() < _skill2.getType())
		{
			return -1;
		}
		else if (_skill1.getType() > _skill2.getType())
		{
			return 1;
		}

		return 0;
	}

	function onSerialize( _out )
	{
		local numSkills = 0;

		foreach( skill in this.m.Skills )
		{
			if (skill.isSerialized())
			{
				numSkills = ++numSkills;
			}
		}

		_out.writeU16(numSkills);

		foreach( skill in this.m.Skills )
		{
			if (skill.isSerialized())
			{
				_out.writeI32(skill.ClassNameHash);
				skill.onSerialize(_out);
			}
		}
	}

	function onDeserialize( _in )
	{
		this.m.IsUpdating = true;
		local numSkills = _in.readU16();

		for( local i = 0; i < numSkills; i = ++i )
		{
			local script = this.IO.scriptFilenameByHash(_in.readI32());

			if (script != null)
			{
				local skill = this.new(script);
				skill.onDeserialize(_in);
				this.add(skill);
			}
			else if (_in.getMetaData().getVersion() >= 57)
			{
				_in.readU8();
			}
		}

		this.m.IsUpdating = false;
		this.update();
	}

};

