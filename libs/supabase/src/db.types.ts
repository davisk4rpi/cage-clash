export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          operationName?: string
          query?: string
          variables?: Json
          extensions?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      fight: {
        Row: {
          createdAt: string
          createdBy: number
          fightCardId: number
          fighter1Id: number
          fighter2Id: number
          id: number
          isCanceled: boolean
          rounds: number
          sex: string
          updatedAt: string
          weight: number
        }
        Insert: {
          createdAt?: string
          createdBy: number
          fightCardId: number
          fighter1Id: number
          fighter2Id: number
          id?: number
          isCanceled?: boolean
          rounds?: number
          sex: string
          updatedAt?: string
          weight: number
        }
        Update: {
          createdAt?: string
          createdBy?: number
          fightCardId?: number
          fighter1Id?: number
          fighter2Id?: number
          id?: number
          isCanceled?: boolean
          rounds?: number
          sex?: string
          updatedAt?: string
          weight?: number
        }
        Relationships: [
          {
            foreignKeyName: "fight_createdBy_fkey"
            columns: ["createdBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fight_fightCardId_fkey"
            columns: ["fightCardId"]
            referencedRelation: "fightCard"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fight_fighter1Id_fkey"
            columns: ["fighter1Id"]
            referencedRelation: "fighter"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fight_fighter2Id_fkey"
            columns: ["fighter2Id"]
            referencedRelation: "fighter"
            referencedColumns: ["id"]
          }
        ]
      }
      fightCard: {
        Row: {
          createdAt: string
          createdBy: number
          id: number
          mainCardStartsAt: string
          name: number
        }
        Insert: {
          createdAt?: string
          createdBy: number
          id?: number
          mainCardStartsAt?: string
          name: number
        }
        Update: {
          createdAt?: string
          createdBy?: number
          id?: number
          mainCardStartsAt?: string
          name?: number
        }
        Relationships: [
          {
            foreignKeyName: "fightCard_createdBy_fkey"
            columns: ["createdBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          }
        ]
      }
      fighter: {
        Row: {
          createdAt: string
          createdBy: number
          id: number
          name: string
        }
        Insert: {
          createdAt?: string
          createdBy: number
          id?: number
          name: string
        }
        Update: {
          createdAt?: string
          createdBy?: number
          id?: number
          name?: string
        }
        Relationships: [
          {
            foreignKeyName: "fighter_createdBy_fkey"
            columns: ["createdBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          }
        ]
      }
      fightOutcome: {
        Row: {
          id: number
          method: Database["public"]["Enums"]["fightOutcomeMethodEnum"]
          round: number | null
        }
        Insert: {
          id?: number
          method: Database["public"]["Enums"]["fightOutcomeMethodEnum"]
          round?: number | null
        }
        Update: {
          id?: number
          method?: Database["public"]["Enums"]["fightOutcomeMethodEnum"]
          round?: number | null
        }
        Relationships: []
      }
      fightOutcomeScore: {
        Row: {
          actFightOutcomeId: number
          id: number
          predictedFightOutcomeId: number | null
          score: number
        }
        Insert: {
          actFightOutcomeId: number
          id?: number
          predictedFightOutcomeId?: number | null
          score: number
        }
        Update: {
          actFightOutcomeId?: number
          id?: number
          predictedFightOutcomeId?: number | null
          score?: number
        }
        Relationships: [
          {
            foreignKeyName: "fightOutcomeScore_actFightOutcomeId_fkey"
            columns: ["actFightOutcomeId"]
            referencedRelation: "fightOutcome"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fightOutcomeScore_predictedFightOutcomeId_fkey"
            columns: ["predictedFightOutcomeId"]
            referencedRelation: "fightOutcome"
            referencedColumns: ["id"]
          }
        ]
      }
      fightPick: {
        Row: {
          confidence: number
          createdAt: string
          createdBy: number
          fightId: number
          fightOutcomeId: number
          id: number
          playerId: number
          updatedAt: string
          updatedBy: number
          winningFighterId: number
        }
        Insert: {
          confidence: number
          createdAt?: string
          createdBy: number
          fightId: number
          fightOutcomeId: number
          id?: number
          playerId: number
          updatedAt?: string
          updatedBy: number
          winningFighterId: number
        }
        Update: {
          confidence?: number
          createdAt?: string
          createdBy?: number
          fightId?: number
          fightOutcomeId?: number
          id?: number
          playerId?: number
          updatedAt?: string
          updatedBy?: number
          winningFighterId?: number
        }
        Relationships: [
          {
            foreignKeyName: "fightPick_createdBy_fkey"
            columns: ["createdBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fightPick_fightId_fkey"
            columns: ["fightId"]
            referencedRelation: "fight"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fightPick_fightOutcomeId_fkey"
            columns: ["fightOutcomeId"]
            referencedRelation: "fightOutcome"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fightPick_playerId_fkey"
            columns: ["playerId"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fightPick_updatedBy_fkey"
            columns: ["updatedBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fightPick_winningFighterId_fkey"
            columns: ["winningFighterId"]
            referencedRelation: "fighter"
            referencedColumns: ["id"]
          }
        ]
      }
      fightResult: {
        Row: {
          createdAt: string
          createdBy: number
          fightId: number
          fightOutcomeId: number
          id: number
          updatedAt: string
          updatedBy: number
          winningFighterId: number
        }
        Insert: {
          createdAt: string
          createdBy: number
          fightId: number
          fightOutcomeId: number
          id?: number
          updatedAt?: string
          updatedBy: number
          winningFighterId: number
        }
        Update: {
          createdAt?: string
          createdBy?: number
          fightId?: number
          fightOutcomeId?: number
          id?: number
          updatedAt?: string
          updatedBy?: number
          winningFighterId?: number
        }
        Relationships: [
          {
            foreignKeyName: "fightResult_createdBy_fkey"
            columns: ["createdBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fightResult_fightId_fkey"
            columns: ["fightId"]
            referencedRelation: "fight"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fightResult_fightOutcomeId_fkey"
            columns: ["fightOutcomeId"]
            referencedRelation: "fightOutcome"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fightResult_updatedBy_fkey"
            columns: ["updatedBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fightResult_winningFighterId_fkey"
            columns: ["winningFighterId"]
            referencedRelation: "fighter"
            referencedColumns: ["id"]
          }
        ]
      }
      league: {
        Row: {
          createdAt: string
          createdBy: number
          description: string
          id: number
          name: string
          updatedAt: string
          updatedBy: number
        }
        Insert: {
          createdAt?: string
          createdBy: number
          description: string
          id?: number
          name: string
          updatedAt?: string
          updatedBy: number
        }
        Update: {
          createdAt?: string
          createdBy?: number
          description?: string
          id?: number
          name?: string
          updatedAt?: string
          updatedBy?: number
        }
        Relationships: [
          {
            foreignKeyName: "league_createdBy_fkey"
            columns: ["createdBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "league_updatedBy_fkey"
            columns: ["updatedBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          }
        ]
      }
      leagueJoinRequest: {
        Row: {
          createdAt: string
          createdBy: number
          id: number
          leagueId: number
          status: Database["public"]["Enums"]["leagueJoinRequestStatusEnum"]
          statusUpdatedAt: string
          statusUpdatedBy: number
        }
        Insert: {
          createdAt?: string
          createdBy: number
          id?: number
          leagueId: number
          status?: Database["public"]["Enums"]["leagueJoinRequestStatusEnum"]
          statusUpdatedAt?: string
          statusUpdatedBy: number
        }
        Update: {
          createdAt?: string
          createdBy?: number
          id?: number
          leagueId?: number
          status?: Database["public"]["Enums"]["leagueJoinRequestStatusEnum"]
          statusUpdatedAt?: string
          statusUpdatedBy?: number
        }
        Relationships: [
          {
            foreignKeyName: "leagueJoinRequest_createdBy_fkey"
            columns: ["createdBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "leagueJoinRequest_leagueId_fkey"
            columns: ["leagueId"]
            referencedRelation: "league"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "leagueJoinRequest_statusUpdatedBy_fkey"
            columns: ["statusUpdatedBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          }
        ]
      }
      leaguePlayer: {
        Row: {
          createdAt: string
          createdBy: number
          id: number
          leagueId: number
          playerId: number
          role: Database["public"]["Enums"]["leaguePlayerRoleEnum"]
        }
        Insert: {
          createdAt?: string
          createdBy: number
          id?: number
          leagueId: number
          playerId: number
          role: Database["public"]["Enums"]["leaguePlayerRoleEnum"]
        }
        Update: {
          createdAt?: string
          createdBy?: number
          id?: number
          leagueId?: number
          playerId?: number
          role?: Database["public"]["Enums"]["leaguePlayerRoleEnum"]
        }
        Relationships: [
          {
            foreignKeyName: "leaguePlayer_createdBy_fkey"
            columns: ["createdBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "leaguePlayer_leagueId_fkey"
            columns: ["leagueId"]
            referencedRelation: "league"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "leaguePlayer_playerId_fkey"
            columns: ["playerId"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          }
        ]
      }
      leaguePlayerHistory: {
        Row: {
          createdAt: string
          createdBy: number
          id: number
          leaguePlayerId: number
          type: string
        }
        Insert: {
          createdAt?: string
          createdBy: number
          id?: number
          leaguePlayerId: number
          type: string
        }
        Update: {
          createdAt?: string
          createdBy?: number
          id?: number
          leaguePlayerId?: number
          type?: string
        }
        Relationships: [
          {
            foreignKeyName: "leaguePlayerHistory_createdBy_fkey"
            columns: ["createdBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "leaguePlayerHistory_leaguePlayerId_fkey"
            columns: ["leaguePlayerId"]
            referencedRelation: "leaguePlayer"
            referencedColumns: ["id"]
          }
        ]
      }
      player: {
        Row: {
          createdAt: string
          displayName: string
          id: number
          uid: string
        }
        Insert: {
          createdAt?: string
          displayName: string
          id?: number
          uid: string
        }
        Update: {
          createdAt?: string
          displayName?: string
          id?: number
          uid?: string
        }
        Relationships: []
      }
      playerRole: {
        Row: {
          createdAt: string
          createdBy: number
          id: number
          playerId: number
          role: Database["public"]["Enums"]["playerRoleEnum"]
        }
        Insert: {
          createdAt?: string
          createdBy: number
          id?: number
          playerId: number
          role: Database["public"]["Enums"]["playerRoleEnum"]
        }
        Update: {
          createdAt?: string
          createdBy?: number
          id?: number
          playerId?: number
          role?: Database["public"]["Enums"]["playerRoleEnum"]
        }
        Relationships: [
          {
            foreignKeyName: "playerRole_createdBy_fkey"
            columns: ["createdBy"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "playerRole_playerId_fkey"
            columns: ["playerId"]
            referencedRelation: "player"
            referencedColumns: ["id"]
          }
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      fighterSex: "male" | "female"
      fightOutcomeMethodEnum:
        | "draw"
        | "no_contest"
        | "decision"
        | "knockout"
        | "submission"
        | "disqualification"
      leagueJoinRequestStatusEnum: "pending" | "rejected" | "accepted"
      leaguePlayerRoleEnum: "admin" | "player"
      playerRoleEnum: "admin" | "player"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  storage: {
    Tables: {
      buckets: {
        Row: {
          allowed_mime_types: string[] | null
          avif_autodetection: boolean | null
          created_at: string | null
          file_size_limit: number | null
          id: string
          name: string
          owner: string | null
          public: boolean | null
          updated_at: string | null
        }
        Insert: {
          allowed_mime_types?: string[] | null
          avif_autodetection?: boolean | null
          created_at?: string | null
          file_size_limit?: number | null
          id: string
          name: string
          owner?: string | null
          public?: boolean | null
          updated_at?: string | null
        }
        Update: {
          allowed_mime_types?: string[] | null
          avif_autodetection?: boolean | null
          created_at?: string | null
          file_size_limit?: number | null
          id?: string
          name?: string
          owner?: string | null
          public?: boolean | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "buckets_owner_fkey"
            columns: ["owner"]
            referencedRelation: "users"
            referencedColumns: ["id"]
          }
        ]
      }
      migrations: {
        Row: {
          executed_at: string | null
          hash: string
          id: number
          name: string
        }
        Insert: {
          executed_at?: string | null
          hash: string
          id: number
          name: string
        }
        Update: {
          executed_at?: string | null
          hash?: string
          id?: number
          name?: string
        }
        Relationships: []
      }
      objects: {
        Row: {
          bucket_id: string | null
          created_at: string | null
          id: string
          last_accessed_at: string | null
          metadata: Json | null
          name: string | null
          owner: string | null
          path_tokens: string[] | null
          updated_at: string | null
          version: string | null
        }
        Insert: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          path_tokens?: string[] | null
          updated_at?: string | null
          version?: string | null
        }
        Update: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          path_tokens?: string[] | null
          updated_at?: string | null
          version?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "objects_bucketId_fkey"
            columns: ["bucket_id"]
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "objects_owner_fkey"
            columns: ["owner"]
            referencedRelation: "users"
            referencedColumns: ["id"]
          }
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      can_insert_object: {
        Args: {
          bucketid: string
          name: string
          owner: string
          metadata: Json
        }
        Returns: undefined
      }
      extension: {
        Args: {
          name: string
        }
        Returns: string
      }
      filename: {
        Args: {
          name: string
        }
        Returns: string
      }
      foldername: {
        Args: {
          name: string
        }
        Returns: unknown
      }
      get_size_by_bucket: {
        Args: Record<PropertyKey, never>
        Returns: {
          size: number
          bucket_id: string
        }[]
      }
      search: {
        Args: {
          prefix: string
          bucketname: string
          limits?: number
          levels?: number
          offsets?: number
          search?: string
          sortcolumn?: string
          sortorder?: string
        }
        Returns: {
          name: string
          id: string
          updated_at: string
          created_at: string
          last_accessed_at: string
          metadata: Json
        }[]
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}
