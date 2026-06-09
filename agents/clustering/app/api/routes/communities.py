from sqlalchemy import select
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.deps import get_db
from app.models.community import Community, CommunityMember

router = APIRouter(prefix="", tags=["communities"])


@router.get("/communities")
def list_communities(db: Session = Depends(get_db)):
    rows = db.execute(select(Community).order_by(Community.size.desc(), Community.name.asc())).scalars().all()
    return [
        {
            "id": row.id,
            "community_key": row.community_key,
            "name": row.name,
            "description": row.description,
            "size": row.size,
            "created_at": row.created_at,
        }
        for row in rows
    ]


@router.get("/community/{community_id}")
def get_community(community_id: int, db: Session = Depends(get_db)):
    community = db.get(Community, community_id)
    if community is None:
        raise HTTPException(status_code=404, detail="Community not found")

    members = (
        db.execute(select(CommunityMember).where(CommunityMember.community_id == community_id))
        .scalars()
        .all()
    )

    return {
        "id": community.id,
        "community_key": community.community_key,
        "name": community.name,
        "description": community.description,
        "centroid": community.centroid,
        "size": community.size,
        "created_at": community.created_at,
        "members": [
            {
                "student_id": member.student_id,
                "student_name": member.student_name,
                "department": member.department,
                "membership_weight": member.membership_weight,
            }
            for member in members
        ],
    }
